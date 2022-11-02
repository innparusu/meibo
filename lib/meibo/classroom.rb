# frozen_string_literal: true

module Meibo
  class Classroom
    DataModel.define(
      self,
      filename: 'classes.csv',
      attribute_name_to_header_field_map: {
        sourced_id: 'sourcedId',
        status: 'status',
        date_last_modified: 'dateLastModified',
        title: 'title',
        grades: 'grades',
        course_sourced_id: 'courseSourcedId',
        class_code: 'classCode',
        class_type: 'classType',
        location: 'location',
        school_sourced_id: 'schoolSourcedId',
        term_sourced_ids: 'termSourcedIds',
        subjects: 'subjects',
        subject_codes: 'subjectCodes',
        periods: 'periods',
        special_needs: 'metadata.jp.specialNeeds'
      },
      converters: {
        boolean: [:special_needs],
        class_type: [:class_type],
        datetime: [:date_last_modified],
        list: [
          :grades,
          :term_sourced_ids,
          :subjects,
          :subject_codes,
          :periods
        ],
        required: [:sourced_id, :title, :class_type, :course_sourced_id, :term_sourced_ids, :school_sourced_id],
        status: [:status]
      }
    )

    TYPES = {
      homeroom: 'homeroom',
      scheduled: 'scheduled'
    }.freeze

    def initialize(sourced_id:, status: nil, date_last_modified: nil, title:, grades: [], course_sourced_id:, class_code: nil, class_type:, location: nil, school_sourced_id:, term_sourced_ids:, subjects: [], subject_codes: [], periods: [], special_needs: nil)
      unless subjects.is_a?(Array) && subject_codes.is_a?(Array) && subjects.size == subject_codes.size
        raise InvalidDataTypeError
      end

      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @title = title
      @grades = grades
      @course_sourced_id = course_sourced_id
      @class_code = class_code
      @class_type = class_type
      @location = location
      @school_sourced_id = school_sourced_id
      @term_sourced_ids = term_sourced_ids
      @subjects = subjects
      @subject_codes = subject_codes
      @periods = periods
      @special_needs = special_needs
    end
  end
end
