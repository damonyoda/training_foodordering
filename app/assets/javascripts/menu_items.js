function outputMenuItems() {
    let menu_items_tbody = document.getElementById("menu_items");
    if (menu_items_tbody) {
        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                let menu_items = JSON.parse(this.responseText);
                let output = "";
                
                for(let i= 0; i <menu_items.length; i++) {
                    
                    output += 
                    
                    `<tr>
                        <td></td>
                        <td> ${menu_items[i].name} </td>
                        <td> ${menu_items[i].unit_price} </td>
                        <td> ${menu_items[i].category.name} </td>
                        <td><input type= 'number' data-menu_item_id = "${menu_items[i].id}"></td>
                        <td><button class= 'addToCartButton'>Add to Cart</button></td>
                    </tr>`
                }  
                menu_items_tbody.innerHTML = output;
                addEventtoButtons();
            }
        };
    xhttp.open("GET", "api/menu_items", true);
    xhttp.send();
    }
}

function addEventtoButtons() {
    let cartbuttons = document.getElementsByClassName('addToCartButton');
    for (let i =0; i < cartbuttons.length; i++) {
        cartbuttons[i].addEventListener("click", function(){
            addToCart(cartbuttons[i]);
        })
    }
}

function addToCart(element) {
    let data = new FormData()
    let quantity_textfield = element.parentElement.previousElementSibling.firstElementChild
    let quantity = quantity_textfield.value
    let menu_item_id = quantity_textfield.getAttribute("data-menu_item_id")
    
    if (quantity) {
        data.append('quantity', quantity);
        data.append('menu_item_id', menu_item_id);
        var qtyandmenuitemid = new XMLHttpRequest();
        qtyandmenuitemid.open("POST", "api/menu_items", true);
        
        qtyandmenuitemid.onload = function() {
            let result = JSON.parse(this.responseText);
            var node = document.createElement("P");
            node.classList = ["notice_message"];
            var textnode = document.createTextNode(result.message);
            node.appendChild(textnode);
            document.getElementById("flash_messages").appendChild(node);
            window.scroll(0,0);
            quantity_textfield.value = "";
        };
       qtyandmenuitemid.send(data); 
    }
    
}

document.addEventListener("DOMContentLoaded", function(event){

    outputMenuItems();
    
});