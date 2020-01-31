const attributeSortingDicitonary = {
  bpm: "bpm_nulls_last",
  key: "key_nulls_last",
  release_title: "r_title_positions",
  release_artist: "r_artist_positions",
  title: "title"
};

interface Options {
  page: number;
  sortBy: Array<keyof typeof attributeSortingDicitonary>;
  sortDesc: boolean[];
}

interface Filters {
  hideNullBpms: boolean;
}

export default class TrackQueryParams {
  options: Options;
  filters: Filters;

  constructor(options: Options, filters: Filters) {
    this.options = options;
    this.filters = filters;
  }

  urlParams() {
    return {
      ...this.pageParam(),
      ...this.sortParam(),
      ...this.filterParams()
    };
  }

  pageParam() {
    if (this.options.page === undefined) return {};

    return {
      "page[number]": this.options.page
    };
  }

  sortParam() {
    const { sortBy } = this.options;
    if (sortBy.length === 0) return {};

    let sortByString!: string;

    sortBy.forEach((attr, index: number) => {
      sortByString = this.sortDirectionModifier(index);
      sortByString += attributeSortingDicitonary[attr];
    });

    return {
      sort: sortByString
    };
  }

  filterParams() {
    if (this.filters.hideNullBpms) {
      return {
        "filter[bpm_not_null]": 1
      };
    }
  }

  sortDirectionModifier(index: number) {
    if (this.options.sortDesc && this.options.sortDesc[index] === true)
      return "-";

    return "";
  }
}
