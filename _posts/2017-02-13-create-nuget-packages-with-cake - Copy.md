---
layout: post
title: "HowTo: Get User Information & Group Memberships from Active Directory via C#"
description: "This blogpost shows how to read data from an Active Directory - including all group memberships of a given user via the Token-Group attribute."
date: 2017-03-02 23:45
author: Robert Muehsig
tags: [Active Directory, .NET]
language: en
---
{% include JB/setup %}

I had to find a way to access all group memberships from a given Active Directory user. The problem here is, that groups may contain other groups and I needed a list of "all" applied group memberships - directly or indirectly.

The "fastest" solution (without querying each group) is to use the __[Token-Groups attribute](https://msdn.microsoft.com/en-us/library/ms680275(v=vs.85).aspx)__, which already does this magic for us. 
This list should contain __all__ applied groups.

The code would also allow to read any other AD property, e.g. the UPN or names etc. 

## Code

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("ListAllGroupsViaTokenGroups:");

            List<string> result = new List<string>();

            try
            {
                result = ListAllGroupsViaTokenGroups("USERNAME", "DOMAIN");

                foreach (var group in result)
                {
                    Console.WriteLine(group);
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.Message);
            }

            Console.Read();
        }

  
        private static List<string> ListAllGroupsViaTokenGroups(string username, string domainName)
        {
            List<string> result = new List<string>();

            using (PrincipalContext domainContext = new PrincipalContext(ContextType.Domain, domainName))
            using (var searcher = new DirectorySearcher(new DirectoryEntry("LDAP://" + domainContext.Name)))
            {
                searcher.Filter = String.Format("(&(objectClass=user)(sAMAccountName={0}))", username);
                SearchResult sr = searcher.FindOne();

                DirectoryEntry user = sr.GetDirectoryEntry();

                // access to other user properties, via user.Properties["..."]

                user.RefreshCache(new string[] { "tokenGroups" });

                for (int i = 0; i < user.Properties["tokenGroups"].Count; i++)
                {
                    SecurityIdentifier sid = new SecurityIdentifier((byte[])user.Properties["tokenGroups"][i], 0);
                    NTAccount nt = (NTAccount)sid.Translate(typeof(NTAccount));

                    result.Add(nt.Translate(typeof(NTAccount)).ToString() + " (" + sid + ")");
                }
            }

            return result;
        }

    }
	
Hope this will help someone in the future.
	
__[Code @ GitHub](https://github.com/Code-Inside/Samples/tree/master/2017/ADLookupWithGroups)__