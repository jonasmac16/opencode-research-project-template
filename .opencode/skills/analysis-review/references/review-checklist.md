# Analysis review checklist

Check as applicable:

- input grain and identifier assumptions;
- filters/exclusions and missing-value semantics;
- join keys/cardinality/unmatched records;
- grouping, aggregation, weighting, ordering, and unit conversions;
- leakage/circularity/contamination between datasets or analysis stages;
- statistical assumptions vs implementation;
- deterministic seeds/parameters and hidden interactive state;
- correct environment/container and dependency assumptions;
- DataLad dataset revision and external-input mutation risk;
- cached/generated outputs invalidated by changed logic;
- tests/fixtures/assertions that cover the failure-prone path;
- documentation sufficient for another analyst to rerun and interpret the work.
