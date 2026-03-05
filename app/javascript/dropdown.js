document.addEventListener("turbo:load", () => {
    const dropdown = document.getElementById('IndexDropdown');
    const menu = document.getElementById('IndexDropdownContents');

    dropdown.addEventListener('click', () => {

        if (menu.style.display === "block") {
            menu.style.display = "none";
        } else {
            menu.style.display = "block";
        }
    });
});