const attributeSortingDicitonary = {
  bpm: "bpm_nulls_last",
  key: "key_nulls_last",
  release: "release_with_position",
  artist: "artist",
  title: "title"
};

interface Options {
  page: number;
  sortBy: Array<keyof typeof attributeSortingDicitonary>;
  sortDesc: boolean[];
}

export default class TrackQueryParams {
  options: Options;

  constructor(options: Options) {
    this.options = options;
  }

  urlParams() {
    return {
      ...this.pageParam(),
      ...this.sortParam()
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

  sortDirectionModifier(index: number) {
    if (this.options.sortDesc && this.options.sortDesc[index] === true)
      return "-";

    return "";
  }
}
