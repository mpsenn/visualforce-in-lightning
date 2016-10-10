origOnload = function() {};
if (window.onload) {
    origOnload = window.onload;
}

window.onload = function() {
    origOnload();
    document.querySelectorAll('.item').forEach(function(item) {
        item.addEventListener('mouseenter', function(e) {
            var element = e.target;
            element.style.backgroundColor = '#00a1e1';
            var button = element.lastElementChild;  
            button.style.display = 'block';
            for (var i = 0; i < element.children.length; i++) {
                element.children[i].style.color = 'white';
            }
        });
    });

    document.querySelectorAll('.item').forEach(function(item) {
        item.addEventListener('mouseleave', function(e) {
            var element = e.target;
            element.style.backgroundColor = '#e7c6e1';
            var button = element.lastElementChild;  
            button.style.display = 'none';
            for (var i = 0; i < element.children.length; i++) {
                element.children[i].style.color = 'black';
            }
        });
    });
}