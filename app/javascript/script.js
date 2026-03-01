document.addEventListener('click', (e) => {
    const btn = e.target.closest('.index-dropdown');

    if (!btn) {
        document.querySelectorAll('.index-dropdown-contents').forEach(m => {
            m.style.display = 'none';
        });
        return;
    }

    const menu = btn.nextElementSibling;

    document.querySelectorAll('.index-dropdown-contents').forEach(m => {
        if (m !== menu) m.style.display = 'none';
    });

    if (menu) {
        if (menu.style.display === 'block') {
            menu.style.display = 'none';
        } else {
            menu.style.display = 'block';
        }
    }
});