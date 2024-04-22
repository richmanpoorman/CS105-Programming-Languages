

PACKAGE   = bignum.smt
TEST_FILE = longtests.smt

all: small-talk

small-talk:
	(echo "(use $(PACKAGE))"; cat) | ledit usmalltalk

test: 
	(echo '(use $(PACKAGE)) (use $(TEST_FILE))'; cat) | ledit usmalltalk

large-test:
	(echo '(use bignum.smt) (use natural-tests.smt)'; \
	 echo '(use $(PACKAGE)) (use $(TEST_FILE))') \
	| usmalltalk -qq

mult-test:
	(echo '(use bignum.smt)'; \
	 echo '({(four * four)} messageTrace)'; \
	 echo '({(neg-four * four)} messageTrace)'; \
	 echo '({(four * neg-four)} messageTrace)'; \
	 echo '({(neg-four * neg-four)} messageTrace)'; \
	) \
	| usmalltalk -qq \
	| grep multiplyByLarge
