(class Element [subclass-of Object]
    [ivars tag attributes]
    (class-method new: (aTag) 
        ((self new) init: aTag))

    (method init: (aTag) 
        (set tag aTag)
        (set attributes (Dictionary new))
        self)

    (method print ()
        ('< print)
        (tag print)
        (attributes associationsDo:
            [block (kv) 
                (space print)
                ((kv key) print)
                ('=" print)
                ((kv value) print)
                ('" print)])
        ('/> print))
    
    (method attribute:put: (att value) 
        (attributes at:put: att value)
        self)
    


)