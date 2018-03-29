export function isDebugBrowser(){
  const ua = window.navigator.userAgent.toLowerCase();
  return ((ua.indexOf('chrome') !== -1 || ua.indexOf('firefox') !== -1) && (ua.indexOf('edge') === -1 && ua.indexOf('ie') === -1)) ? true : false;
}

