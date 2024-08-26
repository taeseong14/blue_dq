// node ~/w.js n(<=60)      -> n sec timeout
// node ~/w.js n(<=60) 1    -> n sec timeout with interval display: waiting {n}s...
// node ~/w.js n(>60)       -> n ms timeout
// node ~/w.js n(>60) 1     -> n ms timeout with initial display: waiting {n}ms...

let ms = +process.argv[2] || 100;
if (ms <= 60) ms *= 1000;
const display = process.argv[3] === '1';

if (ms > 1000) {
    if (display) console.log(`waiting ${ms/1000 |0}s...`);
    setInterval(() => {
        ms -= 1000;
        if (ms > 0) {
            if (display) console.log(`\x1B[2K\x1B[1A\x1B[2Kwaiting ${ms / 1000 |0}s...`);
        } else {
            if (display) console.log(`\x1B[2K\x1B[1A\x1B[2Kwaited ${process.argv[2]}s`);
            process.exit(0);
        }
    }, 1000);
} else {
    setTimeout(() => {
        if (display) console.log(`waited ${ms}ms`);
        process.exit(0);
    }, ms);
}
