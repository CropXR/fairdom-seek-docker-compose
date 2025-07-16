# Custom branding and styling for SEEK
# This file customizes the appearance of your SEEK instance

# Site branding
Seek::Config.site_name = "CropXR Data Hub"
Seek::Config.site_description = "Research data management for crop research"

# Custom CSS styling
Seek::Config.custom_css = "
  .navbar-brand {
    font-weight: bold;
    color: #2e7d32 !important;
  }
  
  .btn-primary {
    background-color: #4caf50;
    border-color: #4caf50;
  }
  
  .btn-primary:hover {
    background-color: #45a049;
    border-color: #45a049;
  }
  
  .page-header {
    border-bottom: 3px solid #4caf50;
  }
  
  .panel-primary > .panel-heading {
    background-color: #4caf50;
    border-color: #4caf50;
  }
  
  .footer {
    background-color: #f8f9fa;
    padding: 20px 0;
    margin-top: 40px;
  }
"

# Custom JavaScript
Seek::Config.custom_javascript = "
  // Add Google Analytics
  // (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  // (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  // m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  // })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
  // ga('create', 'UA-XXXXX-Y', 'auto');
  // ga('send', 'pageview');
  
  // Custom behavior
  $(document).ready(function() {
    console.log('Custom SEEK JavaScript loaded');
  });
"

# Header customization
Seek::Config.header_image_enabled = true
Seek::Config.header_image_title = "CropXR Research Data Hub"
Seek::Config.header_image_link = "https://cropxr.eu"

# Footer customization
Seek::Config.custom_footer = "
  <div class='footer'>
    <div class='container'>
      <div class='row'>
        <div class='col-md-4'>
          <h5>About CropXR</h5>
          <p>Supporting sustainable crop research through data management.</p>
        </div>
        <div class='col-md-4'>
          <h5>Quick Links</h5>
          <ul class='list-unstyled'>
            <li><a href='/help'>Help & Documentation</a></li>
            <li><a href='/contact'>Contact Support</a></li>
            <li><a href='/terms'>Terms of Use</a></li>
          </ul>
        </div>
        <div class='col-md-4'>
          <h5>Contact</h5>
          <p>Email: support@cropxr.eu<br>
          Phone: +31 (0)20 123 4567</p>
        </div>
      </div>
      <hr>
      <div class='text-center'>
        <p>&copy; 2025 CropXR Project. Powered by FAIRDOM-SEEK.</p>
      </div>
    </div>
  </div>
"

# Navigation customization
Seek::Config.custom_navbar_items = [
  {
    title: "CropXR Portal",
    url: "https://cropxr.eu",
    target: "_blank"
  },
  {
    title: "Training",
    url: "/training",
    target: "_self"
  }
]

puts "Custom branding configuration loaded!"