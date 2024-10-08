const fs = require('fs');
const getImageData = require('./getImageData');

const x = +process.argv[2], y = +process.argv[3];
if (!x || !y) {
    console.error('Usage: node ~/getPixelRGB.js <x> <y>');
    process.exit(1);
}

if (!fs.existsSync(__dirname + '/../screen.png')) {
    console.error('screen.png not found');
    process.exit(1);
}

getImageData(__dirname + '/../screen.png')
    .then(({ data, info }) => {
        const index = (y * info.width + x) * 3; // 4 = RGBA (Red, Green, Blue, Alpha)
        const r = data[index];
        const g = data[index + 1];
        const b = data[index + 2];

        fs.writeFileSync(__dirname + '/../result.txt', `${r} ${g} ${b}`);
        if (process.argv[4] === '0') return;
        if (process.argv[4] === '-1') return console.log(`\x1B[2K\x1B[1A\x1B[2KRGB in ../screen.png at (${x}, ${y}): (${r}, ${g}, ${b})`);
        console.log(`RGB in ../screen.png at (${x}, ${y}): (${r}, ${g}, ${b})`);
    })
    .catch(err => {
        console.error(err);
    });