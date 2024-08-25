// node ~/w.js n(<=60)      -> n sec timeout
// node ~/w.js n(<=60) 1    -> n sec timeout with interval display: waiting {n}s...
// node ~/w.js n(>60)       -> n ms timeout
// node ~/w.js n(>60) 1     -> n ms timeout with initial display: waiting {n}ms...

let ms = process.argv[2] || 100;
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

}


// setTimeout(() => process.exit(0), ms);

// const interval = 1000; // 1초마다 업데이트
// let count = 0;

// const timer = setInterval(() => {
//     // 현재 줄을 지우기
//     // process.stdout.write('\x1B[2K'); // 현재 줄을 지우기
//     // // 현재 줄 위로 커서 이동 후 지우기
//     // process.stdout.write('\x1B[1A'); // 한 줄 위로 이동
//     // process.stdout.write('\x1B[2K'); // 줄 지우기
//     process.stdout.write(`\x1B[2K\x1B[1A\x1B[2K현재 카운트: ${count}\n`);
//     count++;

//     // 원하는 조건에 따라 타이머를 종료할 수 있습니다.
//     if (count > 10) {
//         clearInterval(timer);
//     }
// }, interval);
