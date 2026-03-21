/**
 * Cortex Games — AdSense Integration
 * Stub until AdSense approval (requires 3+ games, privacy policy, real traffic).
 * Replace PUBLISHER_ID and SLOT_IDs after approval.
 */
(function() {
  'use strict';

  const CONFIG = {
    publisherId: 'ca-pub-XXXXXXXXXXXXXXXX', // Replace after AdSense approval
    slots: {
      banner:  'XXXXXXXXXX',
      sidebar: 'XXXXXXXXXX',
      mobile:  'XXXXXXXXXX'
    },
    enabled: false // Flip to true after AdSense approval
  };

  function initAds() {
    if (!CONFIG.enabled) return;

    // Load AdSense script
    var s = document.createElement('script');
    s.src = 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=' + CONFIG.publisherId;
    s.async = true;
    s.crossOrigin = 'anonymous';
    document.head.appendChild(s);

    // Initialize ad slots
    document.querySelectorAll('.ad-slot[data-ad-slot]').forEach(function(el) {
      var ins = document.createElement('ins');
      ins.className = 'adsbygoogle';
      ins.style.display = 'block';
      ins.setAttribute('data-ad-client', CONFIG.publisherId);
      ins.setAttribute('data-ad-slot', el.dataset.adSlot);
      ins.setAttribute('data-ad-format', 'auto');
      ins.setAttribute('data-full-width-responsive', 'true');
      el.innerHTML = '';
      el.appendChild(ins);
      (window.adsbygoogle = window.adsbygoogle || []).push({});
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAds);
  } else {
    initAds();
  }
})();
