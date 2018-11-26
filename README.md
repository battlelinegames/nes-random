# NES Random Number Generator
This is a quick and dirty NES pseudo random number generator I threw together.  There is a discussioin on [NES DEV](http://forums.nesdev.com/viewtopic.php?f=10&t=18044) about the method I use.  There is a feeling by some that it will produce numbers that are too predictable in circumstances where there is not a lot of input from the user.  For this to work the way I intended, the code must call the **advance_random_ptr** from every gamepad input.  If you don't do this, the system will just cycle through the numbers in a very predictable way.

I will go into more detail on my [Embed.com NES Tutorials page](https://www.embed.com/nes/)

## rand.asm
To start out, look at the code in the src/lib/rand.asm directory.  This is twhere most of the random code will be.  This won't include your calls to **advance_random_ptr** from the gamepad, but everything else is in there.

### random_ptr
This is a zeropage byte that contains a pointer into the random table.

### frame_counter
This is a zeropage byte that increments on every frame (60 times per second)

### random_table
This is a 128 byte ROM table containing a pre-generated list of 128 random numbers with no repeats.

### advance_random_ptr macro
Whenever this macro is called, it adds the current frame_counter to the pointer into the random table.  Humans are able to time button presses to within 60 milliseconds or so.  The frame counter is updated every 16.6 milliseconds.  This wouldn't provide a whole lot of randomness for a game with very specific timing, but is good enough for many use cases.  If you call advance_random_ptr on all user input it would increase the level of randomness in the game.

### get_random_a macro
This macro calls advance_random_ptr to advance the pointer based on the current frame count.  Then use the value in **random_ptr** as an index into the **random_table**. 

### Advancing the random pointer on a gamepad release
Inside the gameloop I've added the following code which is triggered every time the gamepad is released.  It is redundant for this project because calling get_random_a also advances the random pointer, and I do that on every gamepad press.  I wanted to add the code to demonstrate how it is done in a game that doesn't get a new random number every time the gamepad is pressed.

```
    lda gamepad_release
    beq no_release
        advance_random_ptr
    no_release:
```
