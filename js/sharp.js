const sharp = require('sharp');

// 이미지 파일 경로
const imagePath = 'js/test.jpg';

// 특정 좌표 (예: x=100, y=50)
const x = 2020;
const y = 889;

// 이미지 로드 후 특정 좌표의 RGB 값 추출
sharp(imagePath)
    .raw()
    .ensureAlpha()
    .toBuffer({ resolveWithObject: true })
    .then(({ data, info }) => {
        const index = (y * info.width + x) * 4; // 4 = RGBA (Red, Green, Blue, Alpha)
        const r = data[index];
        const g = data[index + 1];
        const b = data[index + 2];
        const a = data[index + 3];

        console.log(`RGB at (${x}, ${y}): (${r}, ${g}, ${b}, ${a})`);
        // to hex
        console.log(`HEX: #${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`);
    })
    .catch(err => {
        console.error(err);
    });
