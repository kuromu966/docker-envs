export default function sleep(msec) {
  return new Promise(function(resolve){
    setTimeout(resolve, msec);
  });
}
