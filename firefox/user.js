/**
 * Firefox user.js
 *
 * This file is read from the root of the profile directory on browser startup.
 * Preferences are persisted even when removed from this file.
 *
 * References:
 * - https://developer.mozilla.org/en-US/docs/Mozilla/Preferences/Preference_reference
 * - https://github.com/ghacksuserjs/ghacks-user.js/blob/master/user.js
 * - https://github.com/ghacksuserjs/ghacks-user.js/wiki
 * - https://github.com/schomery/privacy-settings
 * - https://ffprofile.com/
 */

// General Preferences
user_pref("app.update.auto", false);

user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtab.url", "about:blank");
user_pref("browser.backspace_action", 2); // 0=previous page, 1=scroll up, 2=do nothing
user_pref("browser.disableResetPrompt", true); // Don't prompt to reset profile after browser not used for a while

// Privacy and Security
user_pref("beacon.enabled", false);
user_pref("browser.send_pings", false);
user_pref("browser.pagethumbnails.capturing_disabled", true); // (hidden pref)
user_pref("network.cookie.cookieBehavior", 1); // 0=allow all, 1=allow same host, 2=disallow all, 3=allow 3rd party if it already set a cookie
user_pref("network.IDN_show_punycode", true); // Help protect against homograph attacks
user_pref("network.http.referer.XOriginPolicy", 1); // 0=always (default), 1=only if base domains match, 2=only if hosts match
user_pref("network.trr.mode", 0); // Disable DNS override to Cloudflare
user_pref("dom.battery.enabled", false);
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.enable_performance", false); // Mitigate JS performance fingerprinting
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.netinfo.enabled", false);
user_pref("dom.vr.enabled", false);
user_pref("dom.webaudio.enabled", false);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);

// Disable various sensor/media APIs
user_pref("geo.enabled", false);
user_pref("webgl.disabled", true);
user_pref("media.video_stats.enabled", false);
user_pref("media.webspeech.recognition.enable", false);
user_pref("media.webspeech.synth.enabled", false);
user_pref("camera.control.face_detection.enabled", false);
user_pref("device.sensors.enabled", false);

// Disable DRM
user_pref("media.eme.enabled", false);
user_pref("media.gmp-widevinecdm.visible", false);
user_pref("media.gmp-widevinecdm.enabled", false);
user_pref("media.gmp-widevinecdm.autoupdate", false);

// Disable WebRTC
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.peerconnection.video.enabled", false);
user_pref("media.peerconnection.identity.enabled", false);
user_pref("media.peerconnection.identity.timeout", 1);
user_pref("media.peerconnection.turn.disable", true);
user_pref("media.peerconnection.ice.tcp", false);
user_pref("media.navigator.video.enabled", false); // video capability for WebRTC

// Prevent leaky/speculative connections
user_pref("network.prefetch-next", false); // Link prefetching
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.dns.disablePrefetch", true); // DNS prefetching
user_pref("network.dns.disablePrefetchFromHTTPS", true); // (hidden pref)
user_pref("network.http.speculative-parallel-limit", 0); // Disable opening connections when hovering links

user_pref("keyword.enabled", false); // Don't leak mistyped domains to search engine
user_pref("browser.fixup.alternate.enabled", false); // Don't guess domain
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.userMadeSearchSuggestionsChoice", true);
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false); // Preloaded "top" websites
user_pref("browser.urlbar.speculativeConnect.enabled", false);

user_pref("network.captive-portal-service.enabled", false);

// Disable telemetry
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

// Disable health reports
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable crash reports
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);

// Disable new tab tile ads & marketing junk
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.source", "data:text/plain,");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.newtabpage.activity-stream.enabled", false);

// Disable safe browsing features, which contact Google and Mozilla servers
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.blockedURIs.enabled", false);

// Disable back door that allows Mozilla to disable addons
user_pref("extensions.blocklist.enabled", false);

// Disable "Get Addons" panel that loads Google Analytics
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.webservice.discoverURL", "");

// Disable back door that allows Mozilla to push experimental changes
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("experiments.activeExperiment", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("extensions.shield-recipe-client.enabled", false);

// Disable back door that allows Mozilla to change preferences
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);

// Disable some built-in extensions
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.screenshots.disabled", true);
