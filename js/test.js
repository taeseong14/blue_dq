const sharp = require('sharp');

const getImageData = async imagePath => sharp(imagePath).raw().removeAlpha().toBuffer({ resolveWithObject: true });

(async () => {
    const { data: icon_data, info: icon_info } = await getImageData('cafe_icon.png');
    // TODO:DEBUG
    console.time();
    // /** @type {number[][]} */
    // const icon_rgb = []; // [r, g, b, r, g, b, ...], [...], ...
    // for (let y = 0, m = icon_info.height; y < m; y++) {
    //     const row = [];
    //     for (let x = 0, n = icon_info.width; x < n; x++) {
    //         const idx = (icon_info.width * y + x) * 3;
    //         row.push(icon_data[idx], icon_data[idx + 1], icon_data[idx + 2]);
    //     }
    //     icon_rgb.push(row);
    // }
    icon_rgb = [[254, 222, 0, 253, 221, 0], [255, 221, 3]]

    const { data, info } = await getImageData('screen.jpg');
    const screen_rgb = [];
    for (let y = 0, m = info.height; y < m; y++) {
        const row = [];
        for (let x = 0, n = info.width; x < n; x++) {
            const idx = (info.width * y + x) * 3;
            row.push(data[idx], data[idx + 1], data[idx + 2]);
        }
        screen_rgb.push(row);
    }


    for (let y = 0, m = screen_rgb.length - icon_rgb.length; y < m; y++) {
        for (let x = 0, n = screen_rgb[0].length - icon_rgb[0].length; x < n; x++) {

            a: for (let yy = 0, mm = icon_rgb.length; yy < mm; yy++) {
                for (let xx = 0, nn = icon_rgb[0].length; xx < nn; xx++) {
                    let diff = 0;
                    
                }
            }

        }
    }



    console.timeEnd();
    console.log(`${screen_rgb[0].length/3}x${screen_rgb.length}`);
})();