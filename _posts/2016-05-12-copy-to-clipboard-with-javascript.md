---
layout: post
title: "Copy to clipboard with Javascript"
description: "It's 2016 and even if we don't have a proper Clipboard API in the modern browser world there are ways to copy text to the users clipboard with pure Javascript."
date: 2016-05-12 23:55
author: Robert Muehsig
tags: [Javascript, HTML]
language: en
---
{% include JB/setup %}

## Clipboard? Current state of the art...

I think everybody knows the clipboard. The goal is that we can store text inside the users clipboard, so he can just paste it. Most sites uses either Flash or some sort of mini-popup with a pre-selected text inside a textarea.

Both ways are not super user friendly and Flash is definitely done.

## Clipboard API?

Currently there are some draft specs for a real clipboard API, but as far as I know, it's far from [done](http://caniuse.com/#feat=clipboard).

__The good news:__ For our use case there is a pretty handy workaround available, which I found on [StackOverflow](http://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript).

## The code:

    <script>
        function detectIE() {
            var ua = window.navigator.userAgent;

            var msie = ua.indexOf('MSIE ');
            if (msie > 0) {
                // IE 10 or older => return version number
                return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
            }

            var trident = ua.indexOf('Trident/');
            if (trident > 0) {
                // IE 11 => return version number
                var rv = ua.indexOf('rv:');
                return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
            }

            // other browser or edge
            return false;
        }

        // source: http://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript
        // enhancement with special case for IEs, otherwise the temp textarea will be visible
        function copyTextToClipboard(text) {
            if (detectIE()) {
                try {
                    window.clipboardData.setData('Text', text);
                    console.log('Copying text command via IE-setData');
                } catch (err) {
                    console.log('Oops, unable to copy via IE-setData');
                }
            }
            else {

                var textArea = document.createElement("textarea");

                //
                //  This styling is an extra step which is likely not required. 
                //
                // Why is it here? To ensure:
                // 1. the element is able to have focus and selection.
                // 2. if element was to flash render it has minimal visual impact.
                // 3. less flakyness with selection and copying which might occur if
                //    the textarea element is not visible.
                //
                // The likelihood is the element won't even render, not even a flash,
                // so some of these are just precautions. 
                // 
                // However in IE the element
                // is visible whilst the popup box asking the user for permission for
                // the web page to copy to the clipboard. To prevent this, we are using 
                // the detectIE workaround.

                // Place in top-left corner of screen regardless of scroll position.
                textArea.style.position = 'fixed';
                textArea.style.top = 0;
                textArea.style.left = 0;

                // Ensure it has a small width and height. Setting to 1px / 1em
                // doesn't work as this gives a negative w/h on some browsers.
                textArea.style.width = '2em';
                textArea.style.height = '2em';

                // We don't need padding, reducing the size if it does flash render.
                textArea.style.padding = 0;

                // Clean up any borders.
                textArea.style.border = 'none';
                textArea.style.outline = 'none';
                textArea.style.boxShadow = 'none';

                // Avoid flash of white box if rendered for any reason.
                textArea.style.background = 'transparent';


                textArea.value = text;

                document.body.appendChild(textArea);

                textArea.select();

                try {
                    var successful = document.execCommand('copy');
                    var msg = successful ? 'successful' : 'unsuccessful';
                    console.log('Copying text command was ' + msg);
                } catch (err) {
                    console.log('Oops, unable to copy');
                }

                document.body.removeChild(textArea);
            }

        }
    </script>

## Usage:

The usage is pretty simple, just call copyToClipboard, e.g.

	<button type="button" onclick="copyTextToClipboard('Foobar!')">
		Set Foobar to clipboard
	</button>

## document.execCommand('copy')

This API is a bit strange, because it only works for visible elements and IE might render a small warning. To get rid of this effect we use a older IE-only API. "document.execCommand" is not limited to copy - there are some nice ideas around it. The __[Mozilla site](https://developer.mozilla.org/de/docs/Web/API/Document/execCommand)__ has a large documentation about this function.
	
A full demo is available on __[JSFiddle](https://jsfiddle.net/uxozxb04/1/)__ and the code is stored on [__GitHub__](https://github.com/Code-Inside/Samples/tree/master/2016/clipboardjs)

Hope this helps.
