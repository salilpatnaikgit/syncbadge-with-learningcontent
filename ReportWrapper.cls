public class ReportWrapper {

	public class FactMap {
		public TiT TiT {get;set;} 

		public FactMap(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'T!T') {
							TiT = new TiT(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'FactMap consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Aggregates {
		public String label {get;set;} 
		public Integer value {get;set;} 

		public Aggregates(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'label') {
							label = parser.getText();
						} else if (text == 'value') {
							value = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Aggregates consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TiT {
		public List<Aggregates> aggregates {get;set;} 
		public List<Rows> rows {get;set;} 

		public TiT(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'aggregates') {
							aggregates = arrayOfAggregates(parser);
						} else if (text == 'rows') {
							rows = arrayOfRows(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'TiT consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Attributes attributes {get;set;} 
	public Boolean allData {get;set;} 
	public FactMap factMap {get;set;} 

	public ReportWrapper(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'attributes') {
						attributes = new Attributes(parser);
					} else if (text == 'allData') {
						allData = parser.getBooleanValue();
					} else if (text == 'factMap') {
						factMap = new FactMap(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'ReportWrapper consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Attributes {
		public String describeUrl {get;set;} 
		public String instancesUrl {get;set;} 
		public Boolean isReportTrendedByAnyone {get;set;} 
		public String reportId {get;set;} 
		public String reportName {get;set;} 
		public String type_z {get;set;} 

		public Attributes(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'describeUrl') {
							describeUrl = parser.getText();
						} else if (text == 'instancesUrl') {
							instancesUrl = parser.getText();
						} else if (text == 'isReportTrendedByAnyone') {
							isReportTrendedByAnyone = parser.getBooleanValue();
						} else if (text == 'reportId') {
							reportId = parser.getText();
						} else if (text == 'reportName') {
							reportName = parser.getText();
						} else if (text == 'type') {
							type_z = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Attributes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class DataCells {
		public String label {get;set;} 
		public String value {get;set;} 

		public DataCells(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'label') {
							label = parser.getText();
						} else if (text == 'value') {
							value = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'DataCells consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Rows {
		public List<DataCells> dataCells {get;set;} 

		public Rows(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'dataCells') {
							dataCells = arrayOfDataCells(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Rows consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static ReportWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new ReportWrapper(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

    private static List<Rows> arrayOfRows(System.JSONParser p) {
        List<Rows> res = new List<Rows>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Rows(p));
        }
        return res;
    }

    private static List<DataCells> arrayOfDataCells(System.JSONParser p) {
        List<DataCells> res = new List<DataCells>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new DataCells(p));
        }
        return res;
    }

    private static List<Aggregates> arrayOfAggregates(System.JSONParser p) {
        List<Aggregates> res = new List<Aggregates>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Aggregates(p));
        }
        return res;
    }



}