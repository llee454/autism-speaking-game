Space Racer Readme
==================

Space Racer is a side scrolling arcade-style video game designed to help children and young adults practice phoneme production under the guidance of a speech therapist. My goal was to create a tool that would motivate children to practice difficult and at times frustrating language skills by embeding this tool as a game that would be fun and engaging.

In Space Racer, the child plays the role of a young spaceship pilot competing in a series of fictional races in space. The child must pilot their racing space ship side to side to collect stars and special abilities using their voice. WHen working with a child, a speech therapist can program the game so that students can steer the ship using different sounds. This allows the child to practice making a series of sound productions - phonemes - while playing a game that hopefully will prove self-motivating.

While Space Racer was initially created to help non-verbal autistic children, it may prove helpful to those suffering from other language production impairments such as stroke and traumatic brain injury.

Space Racer is written as a Processing app. Processing is a Java-based programming language. Unfortunately, the game only runs on MacOS because it relies on [Hear](https://github.com/sveinbjornt/hear) for speech to text translation.

Installation
------------

To install the app, first install Processing. Using the Processing IDE, install the Processing Sound library and the Processing Rita library. Next Install Hear from the linked website.

Starting the Game
----------------

To run the game, you will first need to open a terminal and run the ./listen.sh program included in the project folder. This will start Hear and log all sounds that it hears the player make to a text file that the Space Racer app monitors.

Next open Processing, open the Space Racer within it, and press the run button. This will open the Space Racer app. Therapists, should monitor the console logs at the bottom of the Processing window for status messages and instructions.

Playing the Game
----------------

When Space Racer starts, you will be walked through a picture-book story sequence before the arcade style racing game begins.

Children fly the ship by saying the preprogrammed sounds. They can fly the ship left and right and activate special abilities by saying the preprogrammed sounds. As the game progresses, it tells the child what sounds to make through the text window. Future versions will hopefully add voice acting so that children do not have to read the text.

At times children may either struggle to make certain sounds or the Hear app may fail to accurate hear them. Accordingly, to help students avoid being discouraged, therapists can use keyboard buttons to manually move the space ship if they feel that the student has tried to make the correct sound and is becoming frustrated or discouraged. To fly left, press "a." To fly right, press "d."


Prerequisites
-------------

* [Hear](https://github.com/sveinbjornt/hear)
* Processing
** Processing Sound Library
** Processing Rita Library

Bugs
----


The Listen program (./listen.sh) closes unexpected sometimes. When this happens, pause the game by pressing "p," restart the program, and unpause by pressing "p" again.

Help!
-----

My goal for this game is to make it freely accessible to speech therapists and families, engaging for children, and therapeutically helpfull. 

* Speech Therapists - please give me feedback for ways to improve this game's therapeutic effectiveness.
* Artists - if you will help draw the spaceships, characters, and backgrounds, please contact me!
* Writers - we have a writer but additional help and suggestions - especially translations into other languages are more than welcome!
* Voice actors - if you are a voice actor, here's a small but potentially impactful project!

Author
------

Do not hesitate to reach out. I may be painfully slow to respond. If I do not, please write again, more likely than not, I'm not ignoring you but have simply lost track of your message.

- Larry Lee <llee454@gmail.com>
