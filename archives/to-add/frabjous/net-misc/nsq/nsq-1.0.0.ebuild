# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Note: Keep EGO_VENDOR in sync with Godeps
EGO_VENDOR=(
	"github.com/BurntSushi/toml 2dff111"
	"github.com/bitly/go-hostpool 58b95b1"
	"github.com/nsqio/go-nsq a53d495"
	"github.com/bmizerany/perks 6cb9d9d"
	"github.com/mreiferson/go-options 77551d2"
	"github.com/golang/snappy d9eb7a3"
	"github.com/bitly/timer_metrics afad179"
	"github.com/blang/semver 9bf7bff"
	"github.com/julienschmidt/httprouter 6aacfd5"
	"github.com/judwhite/go-svc 63c1240"
	"github.com/nsqio/go-diskqueue d7805f8"
)

inherit golang-vcs-snapshot

EGO_PN="github.com/nsqio/nsq"
DESCRIPTION="A realtime distributed messaging platform"
HOMEPAGE="http://nsq.io"
SRC_URI="https://${EGO_PN}/archive/v${PV}-compat.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="mirror strip"

DOCS=( {ChangeLog,README}.md )

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

pkg_setup() {
	if use test; then
		has network-sandbox $FEATURES && \
			die "The test phase requires 'network-sandbox' to be disabled in FEATURES"
	fi
}

src_compile() {
	export GOPATH="${G}"

	emake \
	PREFIX="${EPREFIX}/usr" \
	GOFLAGS="-v -ldflags '-s -w'"
}

src_test() {
	./test.sh || die
}

src_install() {
	emake \
		PREFIX="/usr" \
		DESTDIR="${D}" install

	einstalldocs
}
