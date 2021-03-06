class Cppzmq < Formula
  desc "C++ bindings for ZeroMQ"
  homepage "https://github.com/zeromq/cppzmq"
  url "https://github.com/zeromq/cppzmq/archive/v4.7.1.tar.gz"
  sha256 "e9ca2e6a484a8a27eecb3e8576e341926bf734a4d04adc82236be59e79988b59"
  depends_on "zeromq"

  def install
    include.install "zmq.hpp"
    include.install "zmq_addon.hpp"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <zmq.hpp>
      #include <iostream>
      int main()
      {
        int major=0, minor=0, patch=0;
        zmq::version(&major, &minor, &patch);
        std::cout << major << "." << minor << "." << patch << std::endl;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lzmq", "-o", "test"
  end
end
