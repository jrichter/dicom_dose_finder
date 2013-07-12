require 'bundler'

Bundler.require(:default, :development) if defined?(Bundler)

class Connection
  include DICOM

  attr_accessor :ae_title, :port, :ip, :host_ae, :client

  def initialize(ae,port,ip,host)
    @ae_title = ae
    @port = port
    @ip = ip
    @host_ae = host
    create_client
  end

  def echo
    self.client.echo
  end

  def find_todays_studies(modality="CT") # modality is modality in studies and not guaranteed on all PACS
    self.client.find_studies('0008,0020' => Time.now.strftime('%Y%m%d-'), '0008,0061' => modality)
  end

  def find_series(study_uid)
    self.client.find_series('0020,000D' => study_uid)
  end

  def find_images(study_uid,series_uid)
    self.client.find_images('0020,000D' => study_uid, '0020,000E' => series_uid)
  end

  protected

  def create_client
    @client = DICOM::DClient.new(self.ip, self.port, {:ae => @ae_title, :host_ae => @host_ae}) || self.client
  end

end
