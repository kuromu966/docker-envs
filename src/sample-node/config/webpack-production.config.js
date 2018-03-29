const {jsProductionTarget} = require('./targets.src');
const {dllTarget} = require('./targets.dll');
module.exports = [
  dllTarget,
  jsProductionTarget,
];
