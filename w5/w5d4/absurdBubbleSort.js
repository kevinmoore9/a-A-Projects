const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


const askIfGreaterThan = function(el1, el2, callback) {
  reader.question(`Is ${el1} greater than ${el2}?\n`, function(res) {
    callback(res === 'yes' ? true : false);
    // reader.close();
  });
};

const innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length -1) {
    askIfGreaterThan(arr[i], arr[i+1], function(isGreaterThan){
      if(isGreaterThan === true) {
        const temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    });
  }
  if (i === (arr.length-1)) outerBubbleSortLoop(madeAnySwaps);
};


// innerBubbleSortLoop([4,2,1,2], 0, false, ()=> console.log("in outer bubble sort"));

// askIfGreaterThan(4, 7, (bool) => console.log(bool));

const absurdBubbleSort = function(arr, sortCompletionCallback) {
  const outerBubbleSortLoop = function(madeAnySwaps) {
    if (madeAnySwaps === true){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  };
  outerBubbleSortLoop(true);
};

absurdBubbleSort([3, 75, 1, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
