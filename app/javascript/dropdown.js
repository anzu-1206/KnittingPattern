const dropdown = document.getElementById('IndexDropdown');
const menu = document.getElementById('IndexDropdownContents');

dropdown.addEventListener('click', () => {

    if (menu.style.display === "none") {
        menu.style.display = "block";
    } else {
        menu.style.display = "none";
    }
});