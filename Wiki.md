# Game Name: Five Days

### Target Audience

- Players over the age of thirteen

- Players who love puzzle-solving

- Players who like story-oriented game

  

### Number of Players: 1



### Story

​	You, a little girl, forget everything and come into a magical world. You seem to be the only person here, except for a gatekeeper. You couldn't see his face, but you have a strange familiarity to him. Who he is? There's a voice at the bottom of your heart telling you to go home, go to the real world. So you decide to get your memory back, figure it all out and find your homeward way. But first, you need to survive in this world, and meanwhile, try to gather clues. 

​	The day and night of this world are flipped, in the daytime, the world is a platform jumping world and at night, the world is the maze world. At the same time, there are terrifying monsters that haunt the night. What are the monsters and why they are here? Note that once you run out of candles, which can be collected during the daytime, you will be swallowed up in darkness. 

​	The key to getting out of this world and back into the real world is the time of the real world now. Diary, memories, is the unbearable past, or warm story? Amputation, blood marsh, is nightmare or real? What does this homeward way lead to? Does “home” really exist？ The truth may be crueler but also warmer than you think. In the end, after knowing everything that happened, do you still want to go back to "home", the real world, or stay here forever？



### The Game Operation

- Controllers: Keyboard arrows. 

- At daytime:
  
- It’s a platform jumping game with gravity. You can use “←” and “→” to move and “↑” for jumping. You can only jump once unless you touch the ground again.
  
- At night:

  - It’s a maze and you can use “←”, “→”, “↑”, “↓” to move left, right, up and down.

    

### Brief introduction

* This is a story based game. The goal of the game is to collect clues to find the truth of this place. There are lots of clues and you don’t need to collect all of them. But the more clues * * you collect, the more chance you will have to discover the truth. And also, the clues you collect will help you understand the little girl and the thing happened outside. Clues are not easy * to collect; you need to use your brain to find a right way to get the clues. 



### Winning condition

* Find the time in the real world and end the question at the ending page. There will be multiple endings depends on your choice.



### Stages:

* The whole game will have 5 stages. And the special blocks will gradually appear. For example, the cracked floor will only appear in stage after 2. The first stage will be a tutorial stage.

### In each stage, you need to

- At daytime:
  - Move on the floors and reach the end point of the map.
  - Collect candles for light at night, you don’t need to collect all of the candles to pass the stage.
  - Collect diaries of the little girl. This will help you learn more about the background story and is also clue for passing the game.
  - Avoid the traps and trigger the device to help you pass the day/night part. 

- At night:

  - Explore the maze and find the exit.

  - Avoid the attack of the monster wandering in the maze. If you were attacked by the monster for too many time or you candle burns out, you have to give up exploring this maze and go to the next stage. 

  - Collect objects scattered in the maze (also the clues for passing the game). 

    

### Stage design:

- At daytime:
  - Floor: The basic block (black in the picture), you can stand on it and move on it. 
  - Diary: Things contains clues and background story.
  - Candle: Things the little girl can pick up and use at night.
  - Mark: No special effect on daytime, but will become a monster at night (purple in the picture).
  - Cracked floor: Some floor will crack when you stand on it (The red one shown in the picture). You can use it as your tool (for example can restrict the monsters, think of other usage by yourself).
  - Gravity change: In the latter part of the game, the gravity is not only point downward. There will be device that you can trigger (green in the picture) to change the direction of the gravity. (Combined with the cracked floor we can create tricky stage).

- At night:
  - Wall: The floor at daytime will become walls at night and you cannot pass through them. 
  - Monster: It will wander in a straight line back and forth in the maze. It will not go to find and catch the girl actively. It will only walk in the road and when it reach a wall it will turn around and continue walking. If the little girl touches it, she will be sent to the entrance of the maze.
  - Wreckage: Block you can push forward. You need to stand beside it and press the arrow key. It will move toward that direction.
  - Object: Things contains clues and background story.
  - Light area: There will be a light area around the girl and it will gradually shrink. When it disappeared the little girl has to leave this stage and go to the next stage. 



### Stage changing:

​    Between each stage, there will be a corridor. At the end of the corridor the gatekeeper (orange block in the picture) will appear and tell you something about the background story as well as the new things will appear in the next stage. Then he will bring you to the next stage. As the game goes on, part of the corridor will sink and you need to jump over it.



### Clue List:

​    At any time in the game, you can press “C” to check the clues you have already collect.



### Reset Button:

​    Because there exist some place need you to solve a puzzle. There will be a reset button both at daytime and at night. By clicking on this button, the player can reset all the change happened in the maze and return to the entrance. But the consumed time and candle will not reset. And if your candle burns out, you cannot reset. 



### Detailed Settings

* About graphical effect: It will not be the same as examples. We will develop it later use other tools and use image in elm. And the style will be simple but clear. This is a tentative example of the little girl in the game. The background will also be developed soon, we will make it 2.5D probably (seems 3D but actually 2D). And there also may be animation of the candle light (if we have time).

![](lg.png)

* About the graphic workload: Each character need 4 pictures. For the left and right image, we can use mirror flip. And also the image at daytime can be the same as the one at night. And also we will prepare the front and back image for the night maze. 

* About stage difficulty: The difficulty of the stage will be gradually improved.

1. In the first stage there will be no special things and you just need to go through the platform jumping and the maze part (a tutorial stage). 
2. In the second stage the cracked floor at daytime will appear and I will design some trap of the monster. You need to trigger the cracked floor one by one to close the monsters to safely pass the maze at night (a tutorial of the usage of the cracked floor). 
3. In the third stage there will be no cracked floor and one device to change the gravity. You need to first go from up to bottom at daytime and trigger the device. Then you need to turn back to the top and the exit will be there (you can’t go at first because you cannot jump so high). This is a tutorial of the gravity device.
4. And in the following stages I will combine the cracked floor with the gravity change. And it will be a bit difficult. There will be several possible ways of designing the puzzles: 
* You need to change the gravity properly and let the cracked floor dropped up and down to close the monster at top and bottom of the maze. 
* The device maybe also can be triggered by the cracked floor, so you maybe need to make a correct order of triggering the cracked floor and the device. There will be several devices. You may need a proper direction of the gravity to help you use the cracked floor to trigger another device. 


* About technical problem:

1. First is the trigger of the gravity device, it may be easy to mistrigger it. So there may be two ways to deal with this: First is the device can only be trigger once and will disappear. The second is you need to stay close to it and press a button. We will first try to make the second way. If we cannot finish, the first one will be the backup.
2. And for the cracked floor, if the player quickly moves the character below the dropping block bugs may happen. So we may make the dropping speed of the block be faster or let the character be stopped and after the moving of the block is over than it can move again. 
3. And for the night part, it may be difficult to make a light area that can move with the character. We have searched and use the mask property in css to deal with this.
There will also be a reset button in the game. Detailed information was updated in the game playing part in the wiki. We will allow the player to reset the stage if they did sth wrong and cannot pass the stage.


* And don’t worry about the difficulty of each stage because we will put more emphasize on the difficulty of collecting all the clues but not on passing a stage. Which means you may not collect all of the clues but you can still pass the stage and go to the next stage. And in our game you also don’t need to collect all of the clues, some clues may give similar hint but it will tell you more about the background story. The difficulty is for these players who want to achieve a 100% collecting.

* About multiple solution: 
Yes, of course there may be some different way to solve a puzzle if the stage become complex. What we will do is just make sure there will not be a too easy way to get all of the clues. After finishing a map we will play it ourselves and also invite friends to try it to see if there’s anywhere we’ll adjust. And also, in this game, passing the stage will never be the most important and difficult things. If you want to just pass the stage it will not be difficult. But if you want to collect the clues in the map maybe you need to use your brain. So maybe if you come up with a very easy way to collect some clues, it doesn’t matter that much. 



### Poster

##### Aim of the Poster:

- This is for our parents and the company's administrative team. # Requirements for the Poster:
- Visually and with text.

##### What we want to include in the poster:

- Visually appealing display:
  - A Background picture with the two main characters in our game, and beautiful drawing of background elements
  - A big title of our game name in the middle.
  - Team logo, Game logo
  - Possible: some pictures of main elements in our game: mazes, corridor and so on.
  - Blocks of texts

- Texts in short paragraphs inside the blocks:
  - Concept diagram of some sort
  - Features of the game
  - Expected user experience
  - Acknowledgment of the company and the team
  - What we learned in this class



### Booklet Plan

- Our Booklet will contain
  - The game's story background
  - All operations of the game
  - Screenshots of each page
  - The expected user experience



### Video Plan

- Our video will contain
  - Basic introduction of game
  - Start interface, game interface, transition interface, cue interface images
  - The action of the girl in day and night: including jumping, picking up candles, looking for clues, avoiding monsters, being swallowed by darkness, etc
  - Part of the conversation between the girl and the gatekeeper
  - Animation from day to night
  - Final question: real world time, are you willing to leave

- Other
  - The video will be accompanied by appropriate music, perhaps dubbing



### PPT for Presentation

- We are currently working on:
  - learning how to use LaTeX to complete the ppt
  - discussing the main feature that we want to convey to the audience when doing the presentation

- What we plan to include in our ppt:
  - The first page with a beautiful picture demonstrating our game
  - A short, nice background information that will attract the audience; A question posted in the game
  - Basic operation in the game that is necessary for the users to manipulate the game without too much trouble
  - With pictures and necessary words description (operation)
  - Basic idea of the story and what the users need to do
  - A quick showing of the concept diagram and information about our team