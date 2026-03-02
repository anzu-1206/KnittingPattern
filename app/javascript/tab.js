document.addEventListener('turbo:load', function() {
    const tabControl = document.getElementById('tabcontrol');

    if (tabControl == null){
        return;
    }
    
    const tabs = tabControl.querySelectorAll('a');
    const pages = document.getElementById('tabbody').children;

    function changeTab() {
        const targetid = this.href.substring(this.href.indexOf('#')+1,this.href.length);

        for(let i=0; i<pages.length; i++) {
            if( pages[i].id != targetid ) {
                pages[i].style.display = "none";
            }
            else {
                pages[i].style.display = "block";
            }
        }

        for(let i=0; i<tabs.length; i++) {
            tabs[i].style.zIndex = "0";
        }
        this.style.zIndex = "10";

        return false;
    }

    for(let i=0; i<tabs.length; i++) {
        tabs[i].onclick = changeTab;
    }

    tabs[0].onclick();
});