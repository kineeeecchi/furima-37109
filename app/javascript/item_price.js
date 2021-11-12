window.addEventListener('load', function(){
  
  const itemPrice = document.getElementById("item-price");

  itemPrice.addEventListener("input", () => {
    const inputValue = itemPrice.value;
    console.log(inputValue);

    const addTaxPrice = document.getElementById("add-tax-price")
    addTaxPrice.innerHTML = inputValue * 0.1
    console.log(addTaxPrice);

    const itemProfit = document.getElementById("profit")
    const taxValue = inputValue * 0.1
    itemProfit.innerHTML = (Math.floor(inputValue - taxValue));
    console.log(itemProfit);

  })
})


