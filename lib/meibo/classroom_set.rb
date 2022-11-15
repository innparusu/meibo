# frozen_string_literal: true

module Meibo
  class ClassroomSet < DataSet
    def check_semantically_consistent
      super

      each do |classroom|
        roster.organizations.find(classroom.school_sourced_id)
        roster.courses.find(classroom.course_sourced_id)

        if classroom.term_sourced_ids.empty?
          raise DataNotFoundError, "termSourcedIdは1つ以上指定してください"
        end

        classroom.term_sourced_ids.each do |term_sourced_id|
          roster.academic_sessions.find(term_sourced_id)
        end
      end
    end

    def homeroom
      @cache[:homeroom] ||= new(select(&:homeroom?))
    end

    def scheduled
      @cache[:scheduled] ||= new(select(&:scheduled?))
    end
  end
end
