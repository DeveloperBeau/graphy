from printer import print_report, print_page
from banner import make_banner
from casing import title_case


def main():
    print_report(title_case("weekly status"), "all systems nominal")
    print_page("the quick brown fox jumps over the lazy dog", 24, "plain")
    print(make_banner("done"))


if __name__ == "__main__":
    main()
