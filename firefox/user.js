/**
 * Firefox user.js
 *
 * This file is read from the root of the profile directory on browser startup.
 * Preferences are persisted even when removed from this file.
 *
 * References:
 * - https://github.com/ghacksuserjs/ghacks-user.js/blob/master/user.js
 * - https://github.com/ghacksuserjs/ghacks-user.js/wiki
 * - https://github.com/schomery/privacy-settings
 */

// General Preferences
user_pref("app.update.auto", false);

user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtab.url", "about:blank");
user_pref("browser.backspace_action", 2); // 0=previous page, 1=scroll up, 2=do nothing

// Privacy and Security
user_pref("beacon.enabled", false);
user_pref("browser.send_pings", false);
user_pref("network.cookie.cookieBehavior", 1); // 0=allow all, 1=allow same host, 2=disallow all, 3=allow 3rd party if it already set a cookie
user_pref("network.IDN_show_punycode", true);
user_pref("network.http.referer.XOriginPolicy", 1); // 0=always (default), 1=only if base domains match, 2=only if hosts match
user_pref("dom.enable_performance", false); // Mitigate JS performance fingerprinting
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.netinfo.enabled", false);
user_pref("dom.vr.enabled", false);

// Disable various sensor/media APIs
user_pref("geo.enabled", false);
user_pref("webgl.disabled", true);
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
user_pref("network.predictor.enable-prefetch", false); // (FF48+)
user_pref("network.dns.disablePrefetch", true); // DNS prefetching
user_pref("network.dns.disablePrefetchFromHTTPS", true); // (hidden pref)
user_pref("network.http.speculative-parallel-limit", 0); // Disable opening connections when hovering links

user_pref("keyword.enabled", false); // Don't leak mistyped domains to search engine
user_pref("browser.fixup.alternate.enabled", false); // Don't guess domain
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.userMadeSearchSuggestionsChoice", true); // (FF41+)
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false); // Preloaded "top" websites
user_pref("browser.urlbar.speculativeConnect.enabled", false);

user_pref("network.captive-portal-service.enabled", false); // (FF52+)

// Disable telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // (FF55+)
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // (FF55+)

// Disable health reports
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable crash reports
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // (FF51+)
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false); // (FF51+)

// Disable new tab tile ads & marketing junk
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.source", "data:text/plain,");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.newtabpage.activity-stream.enabled", false);

// Disable safe browsing features, which contact Google and Mozilla servers
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false); // (FF50+)
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.blockedURIs.enabled", false);

// Disable Pocket
user_pref("extensions.pocket.enabled", false);

// VimFx Preferences
user_pref("extensions.VimFx.commands.close_tab.keys", ["x"]);
user_pref("extensions.VimFx.commands.scroll_half_page_down.keys", ["d"]);
user_pref("extensions.VimFx.hints.chars", "asdfghjkl;");
