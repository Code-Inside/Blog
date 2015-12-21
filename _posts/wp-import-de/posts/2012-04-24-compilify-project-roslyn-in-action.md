---
layout: post
title: "Compilify – Compiler as a Service ”Project Roslyn” in Action"
date: 2012-04-24 23:49
author: Robert Muehsig
comments: true
categories: [Allgemein]
tags: [C#, Compiler, Compiler-as-a-Service, Roslyn]
language: de
---
{% include JB/setup %}
<p>Heute bin ich durch <a href="https://twitter.com/#!/philipproplesch">Philip Proplesch</a> auf <a href="http://compilify.net/">Compilify</a> aufmerksam geworden:</p> <p><a href="http://compilify.net/"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image1517.png" width="601" height="494"></a></p> <p><a href="http://compilify.net">Compilify</a> funktioniert so ähnlich wie jsFiddler – man kann on the fly Code eingeben und es kommt ein Ergebnis. Da Compilify Open Source ist kann man natürlich auch ein Blick hinter die Kulissen werfen und siehe da: Das “Roslyn” ist im Einsatz!</p> <p><strong>Was ist Roslyn?</strong></p> <p>Ganz stark verkürzt ist Roslyn ein Compiler-as-a-Service, geschrieben in .NET. Das heisst man kann den Compiler auch aus dem Code heraus aufrufen und es gibt eine API um den Syntax zu erkennen und den Code zu kompilieren. Genau das wird auch bei Compilify genutzt.</p> <p><strong>Schauen wir in den Compilify Source Code</strong></p> <p>Leider bekam ich das Projekt auf die schnelle nicht zum Laufen, da man wohl noch eine <a href="http://www.knowyourstack.com/what-is/redis">Redis</a> Instanz braucht und ansonsten irgendwelche Dinge passieren. Naja – interessanter waren für mich zwei Code Teile, welche ich aus dem <a href="https://github.com/Compilify/Compilify">GitHub Repository</a> hier mal übernehme:</p> <p><strong>Wie kommen die Syntax Errors auf die Seite?</strong></p> <p>Wenn ich was völlig falsches eingebe gibt es schicke “Fehlermeldungen”, die auch aus dem Visual Studio hätten kommen können. Auf den ersten Blick scheint dieser Code dieses Verhalten zu erzeugen:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0da7d2ec-4fef-4aec-bcd3-5e1a3b3a5cf9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class CSharpCompiler
    {
        public IEnumerable&lt;IDiagnostic&gt; GetCompilationErrors(string command, string classes)
        {
            var builder = new StringBuilder();

            builder.AppendLine("public static object Eval() {");
            builder.AppendLine("#line 1");
            builder.Append(command);
            builder.AppendLine();
            builder.AppendLine("}");

            var script = builder.ToString();

            var mscorlib = Assembly.Load("mscorlib,Version=4.0.0.0,Culture=neutral,PublicKeyToken=b77a5c561934e089");
            var system = Assembly.Load("System,Version=4.0.0.0,Culture=neutral,PublicKeyToken=b77a5c561934e089");
            var core = Assembly.Load("System.Core,Version=4.0.0.0,Culture=neutral,PublicKeyToken=b77a5c561934e089");

            var namespaces = ReadOnlyArray&lt;string&gt;.CreateFrom(new[]
                             {
                                 "System", 
                                 "System.IO", 
                                 "System.Net", 
                                 "System.Linq", 
                                 "System.Text", 
                                 "System.Text.RegularExpressions", 
                                 "System.Collections.Generic"
                             });

            var compilation = Compilation.Create("foo",
                new CompilationOptions(assemblyKind: AssemblyKind.DynamicallyLinkedLibrary, usings: namespaces),
                new[]
                {
                    SyntaxTree.ParseCompilationUnit(CodeExecuter.EntryPoint), 
                    SyntaxTree.ParseCompilationUnit(script, fileName: "Prompt", options: new ParseOptions(kind: SourceCodeKind.Interactive)),
                    SyntaxTree.ParseCompilationUnit(classes ?? string.Empty, fileName: "Editor", options: new ParseOptions(kind: SourceCodeKind.Script))
                },
                new MetadataReference[]
                { 
                    new AssemblyFileReference(mscorlib.Location),
                    new AssemblyFileReference(core.Location), 
                    new AssemblyFileReference(system.Location)
                });

            return compilation.GetDiagnostics();
        } 
    }</pre></div>
<p>&nbsp;</p>
<p>Sieht eigentlich “relativ” einfach aus – es werden auch nur bestimmte .NET Assemblies geladen und dann wird der Syntax Parser angeworfen. Als Ergebnis kommen Diagnostic Informationen, welche am Ende als Fehler angezeigt werden.</p>
<p><strong>Der CodeExecuter</strong> </p>
<p>Nach der Validierung (und einigen Zwischenschritten) wird der Code am Ende dem CodeExecuter übergeben:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:619d80e8-4d86-410b-ad51-543d6be8cf92" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public class CodeExecuter
    {
        private static readonly string[] Namespaces =
            new[]
            {
                "System", 
                "System.IO", 
                "System.Net", 
                "System.Linq", 
                "System.Text", 
                "System.Text.RegularExpressions", 
                "System.Collections.Generic"
            };

        public const string EntryPoint = @"public class EntryPoint 
                                           {
                                               public static object Result { get; set; }
                      
                                               public static void Main()
                                               {
                                                   Result = Script.Eval();
                                               }
                                           }";

        public object Execute(string command, string classes)
        {
            if (!Validator.Validate(command) || !Validator.Validate(classes))
            {
                return "Not supported";
            } 

            var sandbox = SecureAppDomainFactory.Create();

            // Load basic .NET assemblies into our sandbox
            var mscorlib = sandbox.Load("mscorlib,Version=4.0.0.0,Culture=neutral,PublicKeyToken=b77a5c561934e089");
            var system = sandbox.Load("System,Version=4.0.0.0,Culture=neutral,PublicKeyToken=b77a5c561934e089");
            var core = sandbox.Load("System.Core,Version=4.0.0.0,Culture=neutral,PublicKeyToken=b77a5c561934e089");

            var script = "public static object Eval() {" + command + "}";
            
            var options = new CompilationOptions(assemblyKind: AssemblyKind.ConsoleApplication, usings: ReadOnlyArray&lt;string&gt;.CreateFrom(Namespaces));

            var compilation = Compilation.Create(Guid.NewGuid().ToString("N"), options,
                new[]
                {
                    SyntaxTree.ParseCompilationUnit(EntryPoint),
                    // This is the syntax tree represented in the `Script` variable.
                    SyntaxTree.ParseCompilationUnit(script, options: new ParseOptions(kind: SourceCodeKind.Interactive)),
                    SyntaxTree.ParseCompilationUnit(classes ?? string.Empty, options: new ParseOptions(kind: SourceCodeKind.Script))
                },
                new MetadataReference[] { 
                    new AssemblyFileReference(core.Location), 
                    new AssemblyFileReference(system.Location),
                    new AssemblyFileReference(mscorlib.Location)
                });

            byte[] compiledAssembly;
            using (var output = new MemoryStream())
            {
                var emitResult = compilation.Emit(output);

                if (!emitResult.Success)
                {
                    var errors = emitResult.Diagnostics.Select(x =&gt; x.Info.GetMessage().Replace("Eval()", "&lt;Factory&gt;()")).ToArray();
                    return string.Join(", ", errors);
                }

                compiledAssembly = output.ToArray();
            }

            if (compiledAssembly.Length == 0)
            {
                // Not sure how this would happen?
                return "Incorrect data";
            }

            var loader = (ByteCodeLoader)Activator.CreateInstance(sandbox, typeof(ByteCodeLoader).Assembly.FullName, typeof(ByteCodeLoader).FullName).Unwrap();

            bool unloaded = false;
            object result = null;
            var timeout = TimeSpan.FromSeconds(5);
            try
            {
                var task = Task.Factory
                               .StartNew(() =&gt;
                                         {
                                             try
                                             {
                                                 result = loader.Run("EntryPoint", "Result", compiledAssembly);
                                             }
                                             catch (Exception ex)
                                             {
                                                 result = ex.Message;
                                             }
                                         });

                if (!task.Wait(timeout))
                {
                    AppDomain.Unload(sandbox);
                    unloaded = true;
                    result = "[Execution timed out after 5 seconds]";
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            
            if (!unloaded)
            {
                AppDomain.Unload(sandbox);
            }
            
            if (result == null || string.IsNullOrEmpty(result.ToString()))
            {
                result = "null";
            }

            return result;
        }
    }</pre></div>
<p>&nbsp;</p>
<p>Hier passiert etwas mehr Magic. Es wird ein Kompilat erzeugt und am Ende wird der Bytecode geladen und ausgeführt… noch kann ich nicht ganz folgen was hier im Detail passiert. </p>
<p>Auf alle Fälle interessant ;)</p>
<p>Weitere Hintergrund Infos findet ihr <a href="http://compilify.net/about">hier</a> oder im <a href="https://github.com/Compilify/Compilify">GitHub Repository</a> sowie auf der <a href="http://msdn.microsoft.com/en-us/roslyn">MSDN Roslyn Seite</a>.</p>
