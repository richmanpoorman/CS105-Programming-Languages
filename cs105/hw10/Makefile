

PACKAGES = (use bignum.smt)

all: small-talk

small-talk:
	(echo "$(PACKAGES)"; cat) | ledit usmalltalk

test: 
	(echo '(use bignum.smt) (use longtests.smt)'; cat)| usmalltalk -qq