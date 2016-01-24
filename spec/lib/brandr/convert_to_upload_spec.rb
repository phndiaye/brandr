require 'rails_helper'

describe ConvertToUpload do
  subject { ConvertToUpload.perform(image) }

  describe '.perform' do
    context 'The image hash is wellformed' do
      let(:image) do
        {
          data: 'data:image/jpeg;base64,R0lGODlhDwAPAKECAAAAzMzM/////
                 wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4ML
                 wWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==',
          filename: 'toto.jpeg',
          size: 40072,
          type: 'image/jpeg'
        }
      end

      it 'should return a newly created file in the snippet public folder' do
        expect(subject).to be_a ActionDispatch::Http::UploadedFile
      end

    end

    context 'The image parameter is nil' do
      let(:image) { nil }
      it { expect(subject).to be_nil }
    end
  end
end
