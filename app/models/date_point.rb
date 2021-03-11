# Represents a date at various levels of precisions
#
# Dates in Jesuit Lives can have different levels of precision:
#
#    05-03-1807 - an exact day
#    dd-03-1807 - a month, day unknown
#    dd-mm-1807 - a year, date and month unknown
#
# To reflect these levels of precision while still maintaining different levels
# of precision, DatePoints have a traditional ActiveRecord Date as well as a
# precision indicator.
class DatePoint < ApplicationRecord
  enum precisions: { day: 'day', month: 'month', year: 'year' }

  def display_date
    date_string = self.date.strftime('%d-%m-%Y')

    # @todo Make just year/just month dates come out good.
  end

  # Date for publishing to solr
  def solr_date
    return nil if date.nil?
    self.date.strftime('%Y-%m-%dT00:00:01Z')
  end
end
