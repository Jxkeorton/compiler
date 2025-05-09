
const alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

function cipher (text, key) {
    let cipheredLettersArray = [];

    for(let i = 0; i < text.length; i++){
        const character = text[i].toUpperCase();
        
        if(character === " "){ // Keep spaces unchanged
            cipheredLettersArray.push(" ");
        }

        for(let x = 0; x < alphabet.length; x++){
            if(alphabet[x] === character){
                const new_index = (key + x) % alphabet.length; // Shift letter index
                
                cipheredLettersArray.push(alphabet[new_index]); // Add ciphered letter
            }
        }
    }

    return cipheredLettersArray.join(""); // Return final text
}

const text = cipher('hello world', 4);
console.log(text);
