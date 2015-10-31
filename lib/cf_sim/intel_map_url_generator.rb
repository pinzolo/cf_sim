class CfSim::IntelMapUrlGenerator
  def initialize(portal_map)
    @portal_map = portal_map
  end

  def portal_link(portal)
    "https://www.ingress.com/intel?ll=#{portal.latitude},#{portal.longitude}&pll=#{portal.latitude},#{portal.longitude}"
  end

  def fields_link(fields)
    links = fields.each_with_object([]) { |field, list| list << field.links }.flatten.uniq
    base_point = @portal_map.find_portal(links.first.source_point)
    url_base = "https://www.ingress.com/intel?ll=#{base_point.latitude},#{base_point.longitude}&pls="
    link_url_params = links.map do |link|
      source_portal = @portal_map.find_portal(link.source_point)
      destination_portal = @portal_map.find_portal(link.destination_point)
      "#{source_portal.latitude},#{source_portal.longitude},#{destination_portal.latitude},#{destination_portal.longitude}"
    end
    url_base + link_url_params.join('_')
  end
end
