# Godot 2D player movement challenges

Set up a new Godot project. 
Every challenge is a new main scene.

## **1\. Simple Left/Right Movement**

**Objective:** Create a Sprite2D that can move left and right in response to player input.  
**Description:**

* Create a new 2D Scene and add a `Sprite2D` node. Use any texture you like.
* Attach a script to the `Sprite2D` node. Add a `_process(delta)` function. This code will run every video frame (default is 60 frames per second (FPS)).
  * use `Input.get_axis("ui_left", "ui_right")` to get a movement direction. When using the keyboard arrows, this will be either -1, 0 or 1.
  * Multiply this direction by a speed constant and the `delta` parameter (elapsed seconds since the last frame was rendered) to get the velocity for the movement. Using `delta` makes sure the sprite moves at the same speed if you have a slow graphics card with lower FPS.
  * Add this velocity to the `position.x` property of the sprite.
* Verify that you can run the scene and move the sprite left and right using the arrow keys.

---

## **2\. Four-Directional Top-Down Movement**

**Objective:** Implement movement in four directions (up, down, left, right) suitable for a top-down game.  
**Description:**

* Create a new 2D Scene and add a `Sprite2D` node. Use any texture you like.
* Attach a script to the `Sprite2D` node. Add a `_process(delta)` function.
  * Use `Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")` to get a normalized vector for movement. The vector will contain both an `x` and a `y` component.
  * Multiply this vector by a speed constant and the `delta` parameter. Multiplying a vector with a single values results in both the `x` and `y` components being multiplied with the same value.
  * Add this velocity vector to `position`. The position is also a vector, so the `x` component of the velocity will be added to the `x` component of the position, and similar for the `y` component.
* Verify that you can run the scene and move the sprite in all 4 directions using the arrow keys. Test what happens when you press multiple arrow keys at the same time.
---

## **3\. Rotate and Move Forward**

**Objective:** Create a sprite that rotates and moves in the direction it's facing, without inertia.  
**Description:**

* Create a new 2D Scene and add a Sprite2D to it with a texture you like. 
* The player ship should rotate left and right using keys (e.g., `"ui_left"` and `"ui_right"`). The code for this is similar to the left-right movement from challenge one, but we do not modify `position.x` but the `rotation`.
  * use `Input.get_axis("ui_left", "ui_right")` to get a rotation direction. When using the keyboard arrows, this will be either -1, 0 or 1.
  * Multiply this direction by a speed constant and the `delta` parameter.
  * Add this rotation to the `rotation` property of the sprite.
* Use a separate key (e.g., `"ui_up"`) to move forward in the direction the ship is facing, but only if the key is pressed.
  * use `Input.is_action_pressed("ui_up")` to know if the up key was pressed. 
  * Calculate a direction vector based on the ship's rotation using `Vector2.from_angle(rotation)`.
  * Multiply this direction vector by a speed constant and `delta`, then add it to the sprite's `position`. The sprite should stop immediately when the key is released.
---

## **4\. "Asteroids" Style Movement**

**Objective:** Program movement with inertia and rotation, like in the classic game *Asteroids*.  
**Description:**

* This challenge builds on the previous one. Start with your solution for "Rotate and Move Forward".
* You'll need a `velocity` variable (a `Vector2`) to store the ship's current speed and direction. Initialize it to `Vector2.ZERO`.
* Instead of directly changing the position when "ui_up" is pressed, you'll apply a thrust force. This means adding to the `velocity` vector. The thrust vector is calculated from the ship's rotation, just like before.
* In `_process(delta)`, you will always update the position using `position += velocity * delta`.
* This will cause the velocity to persist even after the thrust key is released, simulating movement in space with no friction.

**Challenge:** Implement "wrapping" where the player ship reappears on the opposite side of the screen when it goes off-screen.  
---

## **5\. Top-Down Movement with Collisions**

**Objective:** Combine 4-directional movement with collisions.  
**Description:**

* Create a new scene.
* Add a `CharacterBody2D` for the player, and a `StaticBody2D` for the obstacles.
* Add two child nodes to the `CharacterBody2D`: a `Sprite2D` with an image you like, and a `CollisionShape2D`. Set the shape of the `CollisionShape2D`. A `CapsuleShape2D` is usually a good choice for the player.
* Add multiple `CollisionShape2D` as children of the `StaticBody2D`. Give them shapes, for example `RectangleShape2D`
* Add a movement script to the CharacterBody2D. Inside `_physics_process(delta)` (which is best for physics code), you will combine the input logic from Challenge 2 with the `move_and_slide()` method:
  * Get an input vector using `Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")`.
  * Set the body's `velocity` by multiplying the input vector by your desired speed. For example: `velocity = direction * SPEED`.
  * Call `move_and_slide()`. This single function handles moving the character based on its `velocity` and stopping it when it hits an obstacle.
  * Note that you do NOT need to multiply by `delta` when `move_and_slide()` is used, this function internally already uses the `delta`.
* Before running the game, you can enable "Visible Collision Shapes" in the "Debug" menu (main window menu) of the Godot Editor. This is very useful for debugging collision issues.

---

## **6\. Simple Platformer Jumping (No Collisions)**

**Objective:** Create a sprite that can jump and is affected by gravity, landing on a virtual "floor".  
**Description:**

* This challenge will teach you the basics of gravity and jumping without using Godot's built-in physics bodies.
* Create a new 2D Scene with a `Sprite2D`.
* Attach a script and define a `velocity` variable (`var velocity = Vector2.ZERO`). You'll also need constants for `GRAVITY` and `JUMP_FORCE`.
* In `_process(delta)`:
  * **Apply Gravity:** Add gravity to the `y` component of your velocity every frame: `velocity.y += GRAVITY * delta`.
  * **Jumping:** If the player presses the jump key (`"ui_accept"`) and the sprite is on the floor, give it an upward velocity: `velocity.y = -JUMP_FORCE`.
  * **Move the player:** Update the sprite's position: `position += velocity * delta`.
  * **Floor Check:** Define a "floor" y-coordinate. If `position.y` goes past this floor, reset it to the floor level and set `velocity.y` to 0. You can check if the sprite is on the floor by seeing if its `position.y` is at (or very close to) the floor level.

**Challenge (Flappy Bird Style):** Modify the jumping code to create "flappy" flight. Instead of only jumping from the floor, allow the player to jump at any time. Remove the floor check so the player is always affected by gravity unless they "flap" upwards. Every press of the jump key should give a small upward boost to the velocity, counteracting gravity for a moment.

---

## **7\. Platformer Movement with Jumps and Collisions**

**Objective:** Create a CharacterBody2D that can move, jump, and interact with platforms.  
**Description:**

* Set up a scene with a `CharacterBody2D` and a `StaticBody2D` (or a TileMap with collisions) to act as the ground.  
* The movement logic should be inside `_physics_process(delta)`.
* **Horizontal Movement:** Get player input for left/right movement using `Input.get_axis("ui_left", "ui_right")`, similar to Challenge 1. Use this to set the `velocity.x` component. For example: `velocity.x = direction * SPEED`. If there is no input, `velocity.x` should go back to zero.
* **Gravity:** If the character is not on the floor (`if not is_on_floor():`), apply gravity by adding to `velocity.y` each frame: `velocity.y += gravity * delta`.
* **Jumping:** Check if the player presses the jump key (e.g., `Input.is_action_just_pressed("ui_accept")`) AND if they are on the ground (`is_on_floor()`). If both are true, give them an upward (negative) vertical velocity: `velocity.y = JUMP_VELOCITY`. `JUMP_VELOCITY` should be a negative number.
* **Apply Movement:** At the very end of the `_physics_process` function, call `move_and_slide()`. This will take your calculated `velocity`, move the player, and handle any collisions with the ground or walls.

**Challenge:** Implement a "double jump" feature. You'll need a variable to track how many jumps the player has left after leaving the ground.

**Challenge (Coyote Time):** Allow the player to jump for a very short period of time after they have walked off a ledge. This makes the controls feel more responsive. You can implement this with a short `Timer` that starts when the player is no longer on the floor. The player can only jump if this timer is running.
---

## **8\. Physics-Based Movement (Wheeled Vehicle)**

**Objective:** Use RigidBody2D to create a car or wheeled vehicle with physics-driven movement.  
**Description:**

* Create a scene with a RigidBody2D for the car body and RigidBody2D nodes for the wheels, connected by PinJoint2D nodes.  
* Instead of directly setting velocity, you'll apply forces and torques.  
* Use apply\_central\_force() to push the car forward or backward.  
* Use apply\_torque() to turn the car.  
* The wheels should be separate RigidBody2D nodes. You can apply forces to the wheels to make them turn, and the PinJoint2D will transfer this force to the car body.

**Hint:** Physics-based movement is much more complex and often requires fine-tuning. Adjusting mass, friction, and torque values is key to getting the right feel. This is a good way to learn about the difference between CharacterBody2D and RigidBody2D.  
---

## **9\. Physics-Based Movement (Rocket Thrusters)**

**Objective:** Create a RigidBody2D that uses multiple thrusters to move and rotate, similar to a space shuttle.  
**Description:**

* Create a RigidBody2D for the rocket.  
* Define several "thruster" points, perhaps using Node2D children as markers.  
* In response to input, use apply\_force() at a specific point relative to the rocket's center of mass.  
* For example, a main thruster would apply\_force() at the back of the rocket, while a rotation thruster would apply force on one side, creating torque.  
* The apply\_force(force, position) function is essential here. The position is relative to the RigidBody2D's origin.

**Challenge:** Create a more complex control scheme where the thrusters fire individually, requiring the player to balance thrusts to move in a straight line or rotate accurately. This provides an excellent introduction to controlling complex physics objects.
