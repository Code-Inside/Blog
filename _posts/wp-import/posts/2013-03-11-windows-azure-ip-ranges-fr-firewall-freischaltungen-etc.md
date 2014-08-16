---
layout: post
title: "Windows Azure IP Ranges – für Firewall-Freischaltungen etc."
date: 2013-03-11 22:33
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Azure, Firewall]
---
{% include JB/setup %}
<p><strong>Wichtig zu verstehen:</strong> Geht man in die Azure-Cloud, spielen feste IP-Adressen eigentlich nicht mehr die Rolle. Alles wird über DNS Einträge gelöst und Microsoft kümmert sich den darunterliegenden Stack. Wer nur in der Wolke arbeitet: Alles super.</p> <p><strong>Firmen-IT &amp; die Cloud – manchmal muss es die IP-Adresse sein</strong></p> <p>Schwieriger wird der Fall wenn man ein Hybrid-Betrieb fahren möchte: Wer SQL Azure nutzen möchte, aber die Anwendung läuft im Firmen-Netz braucht oftmals eine interne Firewall-Freischaltung auf Basis von IP-Adressen bzw. IP-Adressbereichen.</p> <h3>IP-Adress Ranges von Azure (Stand Oktober 2011!)</h3> <p>Leider habe ich keine offiziellen Angaben dazu gefunden, sondern nur durch zufall mit einem Kollegen diese <a href="http://msdn.microsoft.com/en-us/library/windowsazure/hh508976.aspx">Seite</a> entdeckt, welche die IP-Ranges von Oktober 2011 auflistet:</p> <p><strong>United States (South/Central)</strong> <p>65.55.80.0/20, 65.54.48.0/21, 65.55.64.0/20, 70.37.48.0/20, 70.37.64.0/18, 65.52.32.0/21, 70.37.160.0/21, 157.55.103.48/28, 157.55.176.0/20, 157.55.103.32/28, 157.55.192.0/22 <h5></h5> <p><strong>United States (North/Central)</strong> <p>207.46.192.0/20, 65.52.0.0/19, 65.52.48.0/20, 65.52.192.0/19, 209.240.220.0/23, 157.55.136.0/21, 157.55.60.224/28, 157.55.160.0/20 <h5></h5> <p><strong>Europe (North)</strong> <p>213.199.128.0/20, 213.199.160.0/20, 213.199.184.0/21, 94.245.112.0/20, 94.245.88.0/21, 94.245.104.0/21, 65.52.64.0/20, 65.52.224.0/19 <h5></h5> <p><strong>Europe (West)</strong> <p>94.245.97.0/24, 65.52.128.0/19 <h5></h5> <p><strong>Asia (Southeast)</strong> <p>207.46.48.0/20, 111.221.16.0/21, 111.221.80.0/20 <h5></h5> <p><strong>Asia (East)</strong> <p>11.221.64.0/22, 65.52.160.0/19 <p><strong>Benutzung auf eigene Gefahr – hat aber bei mir funktioniert und der Admin war glücklich ;)</strong>
