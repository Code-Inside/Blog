---
layout: post
title: "Angular.js Error: Unknown provider – Angular.js & Js-Minification"
date: 2013-07-10 22:43
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Angular.js, Fix]
language: de
---
{% include JB/setup %}
<p>In einem ASP.NET MVC Projekt setzen wir im Client das Framework <a href="http://angularjs.org/"><strong>Angular.js</strong></a> ein. Recht früh allerdings bekamen wir einen Fehler, auf den man vermutlich sehr schnell stossen wird: </p> <h3>Error: Unkown provider nProvider</h3> <p><a href="{{BASE_PATH}}/assets/wp-images/image1872.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1015.png" width="585" height="276"></a> </p> <p></p> <h3>Dependency Injection… in Javascript!</h3> <p>Angular.js hat ein Dependency Injection System – im einfachen Fall kann dies so aussehen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">function PhoneListCtrl($scope, $http) {
  $http.get('phones/phones.json').success(function(data) {
    $scope.phones = data;
  });
 
  $scope.orderProp = 'age';
}</pre>
<p>Hierbei wird ein Parameter $scope sowie $http übergeben. Über $http lassen sich z.B. einfache HttpRequests abschicken. <strong><u>Das Naming ist hier allerdings entscheident</u></strong>! Nur wenn der Parameter $http heisst kommt auch diese Abhängigkeit da rein.</p>
<h3>Ursprung des Problems: Javascript Minification</h3>
<p>Das obere Problem tritt erst dann auf, wenn man den Javascript Code durch ein Minifier jagt. Im Falle von ASP.NET MVC ist dies über das Bundle Framework bereits integriert und wird im Release-Mode automatisch genutzt. Damit kommt es zu diesem Fehler von oben.</p>
<h3>Problemlösung</h3>
<p>Natürlich hat das Angular.js Team daran gedacht und weisst auch in der <a href="http://docs.angularjs.org/tutorial/step_05">Doku</a> darauf hin – aber hey… wer schaut denn so genau als erstes in die Dokumentation ;)</p>
<p>Um das Problem zu umgehen muss man dem Framework mitteilen in welcher Reihenfolge die Abhängigkeiten rein kommen:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">function PhoneListCtrl($scope, $http) {
  $http.get('phones/phones.json').success(function(data) {
    $scope.phones = data;
  });
 
  $scope.orderProp = 'age';
}
 
PhoneListCtrl.$inject = ['$scope', '$http']; // &lt;-- resolves minifier issue</pre>
<p><a href="http://docs.angularjs.org/tutorial/step_05"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1873.png" width="511" height="458"></a> </p>
<p>Damit sollte es jetzt klappen.</p>
<p>Den Tipp habe ich natürlich auf <a href="http://stackoverflow.com/questions/15720580/why-does-this-angular-controller-throw-error-unknown-provider-nprovider-n">Stackoverflow</a> gefunden.</p>
