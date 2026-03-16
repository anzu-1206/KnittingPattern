document.addEventListener("turbo:load", () => {
    const dropdown = document.getElementById('IndexDropdown');
    const menu = document.getElementById('IndexDropdownContents');

    if (dropdown && menu) {
        if (dropdown.dataset.listenerRegistered) return;

        dropdown.addEventListener('click', () => {
            if (menu.style.display === "block") {
                menu.style.display = "none";
            } else {
                menu.style.display = "block";
            }
        });

        dropdown.dataset.listenerRegistered = "true";
    }
});