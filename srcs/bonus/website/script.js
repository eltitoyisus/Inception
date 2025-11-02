var count = 0;

function increment() {
    count++;
    document.getElementById('count').textContent = count;
}

function decrement() {
    count--;
    document.getElementById('count').textContent = count;
}

document.getElementById('year').textContent = new Date().getFullYear();
