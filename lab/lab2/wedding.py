from z3 import *
xal, xam, xar, xbl, xbm, xbr, xcl, xcm, xcr = Bools('xal xam xar xbl xbm xbr xcl xcm xcr')
s = Solver()

# Alice does not sit next to Charlie
s.add( And( Implies( Or(xal, xar), Not(xcm) ), Implies( xam, And( Not(xcl), Not(xcr)))))

# Alice does not sit on the leftmost chair
s.add( Not(xal) )

# Bob does not sit to the right of Charlie
s.add(And(Implies(xcl, Not(xbm)), Implies(xcm, Not(xbr))))

# Each person gets a chair
s.add(Or(xal, xam, xar))
s.add(Or(xbl, xbm, xbr))
s.add(Or(xcl, xcm, xcr))

# Every person gets at most one chair
s.add(Not(And(xal, xam)))
s.add(Not(And(xal, xar)))
s.add(Not(And(xam, xar)))

s.add(Not(And(xbl, xbm)))
s.add(Not(And(xbl, xbr)))
s.add(Not(And(xbm, xbr)))

s.add(Not(And(xcl, xcm)))
s.add(Not(And(xcl, xcr)))
s.add(Not(And(xcm, xcr)))

# Every chair gets at most one person
s.add(Not(And(xal, xbl)))
s.add(Not(And(xal, xcl)))
s.add(Not(And(xbl, xcl)))

s.add(Not(And(xam, xbm)))
s.add(Not(And(xam, xcm)))
s.add(Not(And(xbm, xcm)))

s.add(Not(And(xar, xbr)))
s.add(Not(And(xar, xcr)))
s.add(Not(And(xbr, xcr)))

if s.check() == sat:
    print("Solution found:")
    print(s.model())
else:
    print("No solution found - unsat")
