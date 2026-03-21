/**
 * Cortex Games — Google Analytics
 * Replace MEASUREMENT_ID after setting up GA4 property.
 */
(function() {
  'use strict';

  var GA_ID = 'G-XXXXXXXXXX'; // Replace with real GA4 measurement ID
  var ENABLED = false;         // Flip to true after GA setup

  if (!ENABLED) return;

  // Load gtag
  var s = document.createElement('script');
  s.src = 'https://www.googletagmanager.com/gtag/js?id=' + GA_ID;
  s.async = true;
  document.head.appendChild(s);

  window.dataLayer = window.dataLayer || [];
  function gtag() { dataLayer.push(arguments); }
  window.gtag = gtag;
  gtag('js', new Date());
  gtag('config', GA_ID);

  // Custom events helper
  window.trackEvent = function(name, params) {
    gtag('event', name, params || {});
  };
})();
