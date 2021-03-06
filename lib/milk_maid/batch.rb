require 'securerandom'

module MilkMaid
  class Batch
    attr_accessor :name, :batch_guid, :temperature, :duration, :size, :notifier, :sensor

    NAP_TIME = 5

    def initialize(options = {})
      options.each { |key, value| send("#{key}=", value) }

      @batch_guid = generate_guid
    end

    def compare_temperature(current_temperature)
      notifier.log_temperature(current_temperature)
      current_temperature.to_i >= temperature.to_i
    end

    def start
      notifier.batch_started(name: name, guid: batch_guid, duration: duration, base_temperature: temperature, batch_size: size)

      until compare_temperature(sensor.reading)
        take_a_nap
      end

      ending_time = Time.now + duration

      notifier.temperature_reached

      until Time.now > ending_time
        current_temp = sensor.reading
        notifier.log_temperature(current_temp)

        notifier.post_warning(current_temp, temperature) if current_temp < temperature

        take_a_nap
      end

      notifier.batch_completed
    end

  private

    def generate_guid
      ::SecureRandom.uuid
    end

    def take_a_nap
      sleep NAP_TIME
    end
  end
end
