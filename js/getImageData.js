const sharp = require('sharp');

/** @type {(imagePath: string) => Promise<{ data: Buffer, info: sharp.OutputInfo }>} */
const getImageData = async imagePath => sharp(imagePath).raw().removeAlpha().toBuffer({ resolveWithObject: true });

module.exports = getImageData;
