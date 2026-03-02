document.addEventListener('click', (e) => {
    const dropdown = e.target.closest('.index-dropdown');

    if (!dropdown) {
        document.querySelectorAll('.index-dropdown-contents').forEach(m => {
            m.style.display = 'none';
        });
        return;
    }

    const menu = dropdown.nextElementSibling;

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