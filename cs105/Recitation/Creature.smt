(class Creature
    [subclass-of Object]
    [ivars isAlive]
    
    (class-method new () ((super new) init))
    
    ;; public
    (method alive? () 
        isAlive)
    (method kill () 
        (set isAlive False)
        self)
    (method canEat: (aCreature)
        (isAlive and: {(self aliveEats: aCreature)} ))

    ;; private
    (method aliveEats: (aCreature) 
        (self subclassResponsibility))

    (method init () 
        (set isAlive true) 
        self)

    (method canBeEatenByChicken? () 
        (self subclassResponsibility))
    
    (method canBeEatenByFlyTrap? () 
        (self subclassResponsibility))
    
    (method canBeEatenByFly? () 
        (self subclassResponsibility))
)   

(class Chicken 
    [subclass-of Creature]
    (method aliveEats: (aCreature) 
        aCreature canBeEatenByChicken?)
        
    (method canBeEatenByChicken? () 
        false)
    
    (method canBeEatenByFlyTrap? () 
        true)
    
    (method canBeEatenByFly? () 
        false)
)

(class ZombieChicken 
    [subclass-of Chicken]
    (method canEat: (aCreature) 
        self aliveEats: aCreature)
)

(class Dog 
    [subclass-of Dog]
    (method aliveEats: (aCreature) 
        (self subclassResponsibility))

    (method canBeEatenByChicken? () 
        (self alive?))
    
    (method canBeEatenByFlyTrap? () 
        true)
    
    (method canBeEatenByFly? () 
        false))