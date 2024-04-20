

PACKAGE   = bignum.smt
TEST_FILE = longtests.smt

all: small-talk

small-talk:
	(echo "(use $(PACKAGE))"; cat) | ledit usmalltalk

test: 
	(echo '(use $(PACKAGE)) (use $(TEST_FILE))'; cat) | ledit usmalltalk