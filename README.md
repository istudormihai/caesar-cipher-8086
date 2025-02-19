# Caesar Cipher in 8086 Assembly  

##  Overview  
The **Caesar Cipher** is a classic encryption technique used since the time of Julius Caesar to securely transmit messages. It works by shifting each letter in the plaintext by a fixed number of positions in the alphabet. This project implements the Caesar Cipher in 8086 Assembly, allowing the user to input a message and a shift value, then displaying the encrypted output.  

##  How It Works  
1. The program first displays a title and prompts the user for:  
   - The plaintext message to encrypt.  
   - The shift value (between 0 and 25).  
2. The input is handled using DOS interrupts (INT 21h):  
   - `INT 21h, 0Ah` → Reads a buffered string input (plaintext).  
   - `INT 21h, 01h` → Reads a single character input (shift value).  
3. The shift value (entered as an ASCII digit) is converted to a numeric value by subtracting ASCII '0'.  
4. The program then iterates through the input string, applying the shift:  
   - Letters A-Z, a-z are shifted and wrapped around if necessary.  
   - Non-alphabetic characters (numbers, punctuation) remain unchanged.  
5. The encrypted message is stored in a buffer and displayed to the user.  

##  Technical Details  
- **Registers Used:**  
  - `SI` → Points to the input buffer (plaintext).  
  - `DI` → Points to the output buffer (encrypted text).  
  - `BL` → Stores the numeric shift value.  
  - `AL` → Temporary storage for processing characters.  
- **Character Encoding:**  
  - Converts letters to a **0-25 range** (`C - A = 2`), applies shift, and wraps if needed.  
  - Converts back to ASCII (`shifted value + 'A'` or `'a'`).  
- **Interrupts Used:**  
  - `INT 21h, 0Ah` → Buffered input for plaintext.  
  - `INT 21h, 01h` → Read character (shift value).  
  - `INT 21h, 09h` → Output the encrypted text.  

##  Example  
### Input  
```
Enter what do you want to encrypt: hello
Shift (0-25): 5  
```
### Output  
```
Encrypted message: mjqqt  
```
### Explanation  
Each letter is shifted by 5 positions in the alphabet. 
